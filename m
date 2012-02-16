From: Sebastian Muniz <basurerosebita@gmail.com>
Subject: Re: sil3132 eSATA problem
Date: Thu, 16 Feb 2012 02:03:31 -0300
Message-ID: <4F3C8E23.70208@gmail.com>
References: <4F3B5885.4070203@gmail.com> <4F3C89E3.1000407@gmail.com> <4F3C8C2F.1060300@gmail.com> <4F3C8D02.6090909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58360 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab2BPFDo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2012 00:03:44 -0500
Received: by ggnh1 with SMTP id h1so1077164ggn.19
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2012 21:03:43 -0800 (PST)
In-Reply-To: <4F3C8D02.6090909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On 2/16/2012 1:58 AM, Robert Hancock wrote:
> Looking at the output a bit more closely, it seems a bit strange. The 
> controller is reporting failures to send a command FIS, and also 
> supposedly seeing uncorrectable errors from the drive. You could try a 
> later kernel but I suspect this may be some kind of hardware issue. 
> Maybe some kind of SATA cable problem?
You might be true, since it is reporting on all the drives.
I will replace the cable, and report back.
Btw, I need to check why but it looks as if an add on PCI ethernet card 
is having some IRQ issues.
The server freezes for 4 seconds and works for 10 more, and so on.
Unloading the module makes the problem go away.
But maybe there is other problem at the bus.
I wanted to make sure there is nothing too obvious from the software 
side before going on site to check.

Thanks in advance
Sebastian

