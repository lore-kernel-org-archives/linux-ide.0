From: Tejun Heo <htejun@gmail.com>
Subject: Re: only one drive in a port multiplier system is being recognized
Date: Mon, 12 Nov 2007 11:58:54 +0900
Message-ID: <4737C16E.3070607@gmail.com>
References: <4730E312.3090900@navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:46739 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbXKLC7C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Nov 2007 21:59:02 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1050287rvb
        for <linux-ide@vger.kernel.org>; Sun, 11 Nov 2007 18:59:02 -0800 (PST)
In-Reply-To: <4730E312.3090900@navy.mil>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gsh@usno.navy.mil
Cc: linux-ide@vger.kernel.org

Greg Hennessy wrote:
> I have a LYCeSATA-4x pci card that is port multiplier compatible (it
> works fine
> under win xp) that is only showing one of 5 attached drives when
> attached to
> a Redhat 5 computer, with both  2.6.18-8.1.15.el5 and 2.6.23.1.
> The SATA link shows as up for the one recognized drive, the other four
> drives show the link down.
> Any sugguestions as to what may be the problem?

Stock 2.6.23.1 doesn't have PMP support.  2.6.24 will.  You need patches
from the following page.

http://home-tj.org/wiki/index.php/Libata-tj-stable

-- 
tejun
