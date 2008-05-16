From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.25 -> 2.6.26-rc1: pcmcia flash card changed name from hda to hdc
Date: Fri, 16 May 2008 21:40:48 +0200
Message-ID: <200805162140.49501.bzolnier@gmail.com>
References: <20080515132313.GA1558@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.179]:11267 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbYEPTuM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 May 2008 15:50:12 -0400
Received: by ik-out-1112.google.com with SMTP id c28so233888ika.5
        for <linux-ide@vger.kernel.org>; Fri, 16 May 2008 12:50:08 -0700 (PDT)
In-Reply-To: <20080515132313.GA1558@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org


Hi,

On Thursday 15 May 2008, Pavel Machek wrote:
> Hi!
> 
> After update to 2.6.26-rc1, CF card (in pcmcia slot) moved from hda to
> hdc on thinkpad x60 (and broke my scripts).
> 
> Is that intentional?

Please send dmesgs for 2.6.25 and 2.6.26-rc1 so we can tell more.

Thanks,
Bart
