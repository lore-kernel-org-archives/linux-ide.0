From: Tejun Heo <htejun@gmail.com>
Subject: Re: VIA VT6420 SATA suspend/resume problem in 2.6.20?
Date: Thu, 03 May 2007 16:45:47 +0200
Message-ID: <4639F59B.1080009@gmail.com>
References: <e34e42440705030542r1574dfdre143e2d43edd44d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:17724 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260AbXECOp4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2007 10:45:56 -0400
Received: by wx-out-0506.google.com with SMTP id h31so462433wxd
        for <linux-ide@vger.kernel.org>; Thu, 03 May 2007 07:45:56 -0700 (PDT)
In-Reply-To: <e34e42440705030542r1574dfdre143e2d43edd44d6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeroen Janssen <jeroen.janssen@gmail.com>
Cc: linux-ide@vger.kernel.org

Jeroen Janssen wrote:
> Hello,
> 
> I have a board with a VIA 6420 chipset and a SATA harddisk running on
> 2.6.20 (Fedora Core 6).
> 
> When I suspend the system, it goes to sleep instantly, but when I
> wakeup the system, it takes about 2 x 30 seconds for the SATA disk to
> be accessable again.
> 
> I searched the mailinglist and could not really find if this is a
> known problem (although I noticed that there's some work going on in
> the acpi power management).
> 
> Does anyone if this is a known problem? (and if so, is there a
> solution available?)
> How can I pinpoint the exact problem?
> 
> If you need any specific logging, just let me know and I'll provide them.

The result of dmesg after resume would be nice.

-- 
tejun
