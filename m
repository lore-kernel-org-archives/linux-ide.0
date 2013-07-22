From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add additional queued command opcodes from SATA
 spec
Date: Mon, 22 Jul 2013 16:00:14 -0400
Message-ID: <20130722200014.GA4042@mtj.dyndns.org>
References: <CAO1A-8DmPXdM-XbzD18aQUYy4+Aph0jVwrSe1_spJJcRM57NNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:62927 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933206Ab3GVUA1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jul 2013 16:00:27 -0400
Received: by mail-qc0-f177.google.com with SMTP id n1so3837300qcx.36
        for <linux-ide@vger.kernel.org>; Mon, 22 Jul 2013 13:00:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAO1A-8DmPXdM-XbzD18aQUYy4+Aph0jVwrSe1_spJJcRM57NNQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Fri, Jul 19, 2013 at 06:17:14PM -0700, Marc C wrote:
> This patch adds the new queued opcodes to the ATA device command
> list.
> 
> Rev 3.0 and 3.1 of the SATA spec introduced the following
> opcodes:
> 
> - NCQ QUEUE MANAGEMENT
> - SEND FPDMA QUEUED
> - RECEIVE FPDMA QUEUED

Hmmm, are you planning to add code making use of the above new
commands soon?  If not, why add the opcodes at all?  ata.h isn't
aiming to contain all possible ATA commands.

Thanks.

-- 
tejun
