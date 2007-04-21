From: "David Lebel" <lebel@lebel.org>
Subject: Re: Correct way to enable port multiplier support in kernel 2.6.20-1?
Date: Sat, 21 Apr 2007 10:42:55 -0400
Message-ID: <d03b6e70704210742w63d07e8dk9fe590c412ef5c23@mail.gmail.com>
References: <d03b6e70704202019gfd7a20atbd9035daacfa9e48@mail.gmail.com>
	 <20070421033600.GA14976@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:47560 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031252AbXDUOm4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Apr 2007 10:42:56 -0400
Received: by an-out-0708.google.com with SMTP id b33so1282087ana
        for <linux-ide@vger.kernel.org>; Sat, 21 Apr 2007 07:42:55 -0700 (PDT)
In-Reply-To: <20070421033600.GA14976@curie-int.orbis-terrarum.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, robbat2@gentoo.org

On 4/20/07, Robin H. Johnson <robbat2@gentoo.org> wrote:
> Tejun Heo did the initial stuff, and I used his Git tree to update some
> patches to a 2.6.20rc2+libata-upstream level.
>
> Those patches I published here:
> http://dev.gentoo.org/~robbat2/libata-development/
> The sign-off lines esp for the hp_poll should probably reference Tejun,
> unless he just picked them up somewhere else.

I did get the linux-2.6.20rc2 tarball from kernel.org, but when I
tried to apply the patches from your link, the first ones seems to
have been applied already for some of the files, so I had .rej files
for some of the chunks. It was late tho, didn't go far.

I never used git myself, as I said, I'm not a kernel guru, I'm just a
sysadmin :)

However, I can handle patch, and if I know the correct way to do it, I
could do it on a specific version of the kernel.

Ciao,
  ...David

-- 
// david lebel <lebel@lebel.org>
// http://www.lebel.org/
// pgp: 3633 6999 D47E 73ED 099F  4341 08A4 8E48 EF56 61D1
