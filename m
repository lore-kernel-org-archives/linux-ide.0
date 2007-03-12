From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata#upstream 2/2] sata_promise: separate SATA and PATA
 ops
Date: Mon, 12 Mar 2007 18:20:21 +0900
Message-ID: <45F51B55.1050202@gmail.com>
References: <200703112020.l2BKKh5P018685@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:62720 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965417AbXCLJUV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 05:20:21 -0400
Received: by an-out-0708.google.com with SMTP id b33so1359900ana
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 02:20:20 -0700 (PDT)
In-Reply-To: <200703112020.l2BKKh5P018685@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> This patch changes sata_promise so that the PATA ports
> on TX2plus chips are bound to the pdc_pata_ops structure.
> This means that operations called from the SATA ops
> structures don't need any SATA-vs-PATA tests any more.
> Instead, operations that depend on a port being SATA or
> PATA are separated into different procedures.
> 
> * pdc_cable_type() is split into a PATA version and a
>   SATA version
> * pdc_error_handler() is split into a PATA version and a
>   SATA version, that both call a common version after
>   setting up the `hardreset' function pointer
> * pdc_old_check_atapi_dma() is now only used for SATAI
>   ports, so is renamed to pdc_old_sata_check_atapi_dma()
>   and simplified
> * pdc_sata_scr_{read,write}() are now only used for SATA
>   ports, so their is-not-SATA tests are removed
> * pdc_port_start() is split into three procedures: a wrapper
>   which performs the ->ops adjustment on TX2plus PATA ports,
>   a procedure with the common code, and a procedure with
>   the SATA-specific code (this bit might be cleaned up by
>   Tejun's new init model)

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
