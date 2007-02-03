From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (2.6.20-rc7) alim15x3: fix PIO mode setup
Date: Sat, 03 Feb 2007 22:53:21 +0100
Message-ID: <45C50451.1030108@gmail.com>
References: <200702032219.45153.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:63403 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbXBCVsc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 16:48:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1037079uga
        for <linux-ide@vger.kernel.org>; Sat, 03 Feb 2007 13:48:31 -0800 (PST)
In-Reply-To: <200702032219.45153.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Sergei Shtylyov wrote:
> The driver's tuneproc() method fails to set the drive's own speed -- fix this
> by renaming the function to ali15x3_tune_pio() and "wrapping" the new tuneproc()
> method around it and making it return the mode set, update the heading comment.
> 
> Also, setting PIO mode via the speedproc() method does not work due to passing 
> to the tuneproc() method's a mode number not biased by XFER_PIO_0 -- fix this
> along with a typo in the heading comment...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied, thanks
