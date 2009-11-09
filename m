From: Tejun Heo <tj@kernel.org>
Subject: Re: Some of mine ST31000520AS drives unloads head very frequent and
 I 	cannot set APM on them
Date: Mon, 09 Nov 2009 17:19:49 +0900
Message-ID: <4AF7D0A5.5030502@kernel.org>
References: <e44195c70909080124s62cc6841t617c2ce662222687@mail.gmail.com> <e44195c70909080252q18e26886p8adbf6183b70ebc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55372 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138AbZKIITt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Nov 2009 03:19:49 -0500
In-Reply-To: <e44195c70909080252q18e26886p8adbf6183b70ebc2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fredrik Tuomas <fredrik.tuomas@gmail.com>
Cc: linux-ide@vger.kernel.org

Sorry about the long delay.

Fredrik Tuomas wrote:
> In the pdf on
> 
> http://www.seagate.com/staticfiles/support/disc/manuals/desktop/Barracuda%20LP/100564361a.pdf
> 
> you can read that APM is not supported on the disk. Now I'm confused.
> I can set APM on at least one of my drives. How can I prohibit the
> excessive loading/unloading of the heads if APM not is supported?

There are drives with vendor specific commands for controlling
powersaving behavior.  Unfortunately, you'll have to contact the
vendor for those.  :-(

Thanks.

-- 
tejun
