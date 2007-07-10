From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/12] jmicron: PIO fixes
Date: Tue, 10 Jul 2007 22:26:53 +0200
Message-ID: <200707102226.53206.bzolnier@gmail.com>
References: <200707081536.04816.bzolnier@gmail.com> <46924197.6000003@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:59871 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760266AbXGJWEn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 18:04:43 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1363733wxd
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 15:04:43 -0700 (PDT)
In-Reply-To: <46924197.6000003@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 09 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Set transfer mode on the device in jmicron_tuneproc(),
> >   also add pio == 255 == "auto-tune" handling.
> 
> > * Use jmicron_tuneproc() in jmicron_config_drive_for_dma().
> 
> > * Remove no longer needed config_jmicron_chipset_for_pio().
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
