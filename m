From: Tejun Heo <htejun@gmail.com>
Subject: Re: ahci problems with sata disk.
Date: Mon, 15 Jan 2007 18:13:22 +0900
Message-ID: <45AB45B2.2080602@gmail.com>
References: <1168785128.7865.13.camel@duo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:14394 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932122AbXAOJNc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jan 2007 04:13:32 -0500
Received: by an-out-0708.google.com with SMTP id b33so738756ana
        for <linux-ide@vger.kernel.org>; Mon, 15 Jan 2007 01:13:31 -0800 (PST)
In-Reply-To: <1168785128.7865.13.camel@duo>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
Cc: linux-ide@vger.kernel.org

kenneth johansson wrote:
> I changed my bios setting for SATA from IDE to AHCI.
> 
> This resulted in some "interesting" read throughput. 
> 
> plots can be found at http://kenjo.org/~ken/sata/
> The plots was done on a live disk so some noise is expected but in the
> ahci mode the throughput get stuck at 17 MB way to much.

It's probably not an ahci problem but more of NCQ implementation problem
in the drive firmware.  Please report the result of 'hdparm -I /dev/sdX'
and try adjust queue depth and see what happens.

http://linux-ata.org/faq.html

-- 
tejun
