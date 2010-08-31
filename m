From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [opensuse-kernel] SSD / filesystem / TRIM
Date: Tue, 31 Aug 2010 09:05:01 -0400
Message-ID: <4C7CFDFD.5000902@teksavvy.com>
References: <4C759825.60503@web.de>	<AANLkTimrOOPExu+hU9wNubT3wgJWwUxMwjREn2p=x-qT@mail.gmail.com>	<4C7A2949.8070606@web.de>	<AANLkTinNt83RYu+ssRHzLT=E+Nk5kTk4Q+sfxQk5SP4+@mail.gmail.com>	<4C7CF740.9040907@teksavvy.com> <AANLkTinBG0CjPZe1+ViHp9ir95sPvJ=XADT2a3LdbF3i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:15497 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752587Ab0HaNFD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Aug 2010 09:05:03 -0400
In-Reply-To: <AANLkTinBG0CjPZe1+ViHp9ir95sPvJ=XADT2a3LdbF3i@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Thomas Hertweck <Thomas.Hertweck@web.de>, opensuse-kernel@opensuse.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On 10-08-31 08:51 AM, Greg Freemyer wrote:
>
> Does hdparm v.9.30 have any known kernel dependencies that would keep
> it from working with 2.6.31?
>
> Or any other known issues that would argue against opensuse pushing it
> out as a software update for 11.2 and 11.3?
>
> Or at least putting it in a OBS repo so people using wiper.sh/hdparm
> can use the latest if they load if from the repo..


No issues that I know about.
My own opinion, is that _anyone_ using hdparm should be using v9.30.

Cheers
