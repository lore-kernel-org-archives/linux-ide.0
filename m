From: Hans Mueller <hans42mueller@googlemail.com>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Fri, 18 Jun 2010 15:08:00 +0200
Message-ID: <20100618150800.4a3b1d68@cpc>
References: <20100617080726.GA13713@liondog.tnic>
	<20100617150008.16a5e653@cpc>
	<20100618074510.GD32368@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49413 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761215Ab0FRNHe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jun 2010 09:07:34 -0400
Received: by fxm10 with SMTP id 10so598035fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 18 Jun 2010 06:07:33 -0700 (PDT)
In-Reply-To: <20100618074510.GD32368@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Hi,

a questions to you Boris:

On Fri, 18 Jun 2010 09:45:10 +0200
Borislav Petkov <bp@alien8.de> wrote:
> [...] and do catch the _complete_ output again.
Can you tell me how to do this? Can I make the kernel to wait until I connect 
with firescope?
As far as I know, I can only connect if the kernel already loaded / initialized the firewire drivers,
when using firescope. Therefore I cannot 'connect' before the kernel started booting, can I?


Regards Jonas
