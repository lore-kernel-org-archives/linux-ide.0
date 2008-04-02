From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
Subject: Re: 2.5.25 regression from 2.6.24: smartctl fails to access drive
Date: Wed, 2 Apr 2008 00:06:03 -0600
Message-ID: <97a0a9ac0804012306h18c83defk99231717100b7a70@mail.gmail.com>
References: <97a0a9ac0804012300qeb3e63gbb7e30ffa1ccdb70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.240]:25073 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYDBGGF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 02:06:05 -0400
Received: by hs-out-0708.google.com with SMTP id 4so2000297hsl.5
        for <linux-ide@vger.kernel.org>; Tue, 01 Apr 2008 23:06:03 -0700 (PDT)
In-Reply-To: <97a0a9ac0804012300qeb3e63gbb7e30ffa1ccdb70@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com

Hi All

On Wed, Apr 2, 2008 at 12:00 AM, Gordon Farquharson
<gordonfarquharson@gmail.com> wrote:

>  Since then, I manually found that the problem commit occurred between
>  2.6.24 and 2.6.25-rc1. At that point, I started using git-bisect, but
>  all kernels I have tested so far fail to boot on the GLAN Tank.

Update: commit 4383f18b7f94a4d668c5eec68645c75d44556235 does boot, but
smartctl fails with this kernel. I may have time to do a couple of
more git-bisects.

Gordon

-- 
Gordon Farquharson
GnuPG Key ID: 32D6D676
