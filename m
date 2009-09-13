From: "Christoph .J Thompson" <cjsthompson@gmail.com>
Subject: Re: Can't burn CDs/DVDs
Date: Sun, 13 Sep 2009 05:36:53 +0200
Message-ID: <20090913053653.7b7bf4db.cjsthompson@gmail.com>
References: <20090911193017.d47e167e.cjsthompson@gmail.com>
	<4AABD55A.9030800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:61496 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbZIMDgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Sep 2009 23:36:07 -0400
Received: by ewy2 with SMTP id 2so2095412ewy.17
        for <linux-ide@vger.kernel.org>; Sat, 12 Sep 2009 20:36:09 -0700 (PDT)
In-Reply-To: <4AABD55A.9030800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, 12 Sep 2009 11:07:38 -0600
Robert Hancock <hancockrwd@gmail.com> wrote:
> ugh.. this sort of thing being a reason to try libata instead :-) In the 
> long term that would likely be best as the IDE drivers are no longer 
> very widely used and are less maintained.

And off I go compile a kernel ;)

> It's not clear what command it's complaining about that has failed. 
> First it says that test unit ready succeeded, then it says that the 
> drive reported a "medium not present" error. Is there any way to enable 
> any more debugging in cdrecord? If you retry the burning attempt does 
> the same thing happen?

Yes, it always does the same thing. I tried another DVD/CD-RW drive just in case. It doesn't work properly either, but it goes a bit further and starts burning the CD-R and the ripping process dies at between 12-14%. On Windows with this drive the burning process goes to the end. Probably switching to libata will fix it.

Thanks for your help.

C.

-- 
PGP: 0xC189F229
