From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
Subject: Re: 2.5.25 regression from 2.6.24: smartctl fails to access drive
Date: Wed, 2 Apr 2008 20:07:56 -0600
Message-ID: <97a0a9ac0804021907g699bc40g32174a05a6b26b88@mail.gmail.com>
References: <97a0a9ac0804012300qeb3e63gbb7e30ffa1ccdb70@mail.gmail.com>
	 <97a0a9ac0804012306h18c83defk99231717100b7a70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:37353 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758500AbYDCCH5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 22:07:57 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3170297wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2008 19:07:56 -0700 (PDT)
In-Reply-To: <97a0a9ac0804012306h18c83defk99231717100b7a70@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com

On Wed, Apr 2, 2008 at 12:06 AM, Gordon Farquharson
<gordonfarquharson@gmail.com> wrote:

>  On Wed, Apr 2, 2008 at 12:00 AM, Gordon Farquharson
>  <gordonfarquharson@gmail.com> wrote:
>
>  >  Since then, I manually found that the problem commit occurred between
>  >  2.6.24 and 2.6.25-rc1. At that point, I started using git-bisect, but
>  >  all kernels I have tested so far fail to boot on the GLAN Tank.

The earliest commit between 2.6.24 and 2.6.25-rc1 that boots on the
GLAN Tank is 66a2c077c36ee5c56e77ba3757702c4464011da6. Unfortunately,
smartctl does not work with this kernel, so the commit that is causing
the problem must have been made before this commit.

I guess the next step will be to revert the IDE commits before
66a2c077c36ee5c56e77ba3757702c4464011da6 one by one to see when
smartctl starts working. Is there an easy way to list all the commits
to drivers/ide that occurred before
66a2c077c36ee5c56e77ba3757702c4464011da6? I'll try this when I have
access to the hardware again (in around two weeks).

Gordon

-- 
Gordon Farquharson
GnuPG Key ID: 32D6D676
