From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] libata: add missing PM callbacks
Date: Fri, 2 Mar 2007 12:56:37 +0000
Message-ID: <20070302125637.02508d61@lxorguk.ukuu.org.uk>
References: <20070302083001.GK20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33734 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933339AbXCBLwa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 06:52:30 -0500
In-Reply-To: <20070302083001.GK20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Fri, 2 Mar 2007 17:30:01 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Some LLDs were missing scsi device PM callbacks while having host/port
> suspend support.  Add missing ones.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
>
Acked-by: Alan Cox <alan@redhat.com>
