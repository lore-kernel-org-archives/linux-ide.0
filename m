From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 03 Dec 2009 17:30:50 -0500
Message-ID: <4B183C1A.3080609@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200912032306.52022.bzolnier@gmail.com> <4B18376B.3080404@garzik.org> <200912032323.39846.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:41768 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZLCWas (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 17:30:48 -0500
In-Reply-To: <200912032323.39846.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/03/2009 05:23 PM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 03 December 2009 11:10:51 pm Jeff Garzik wrote:
>> Is it good kernel practice to intermingle cosmetic changes with
>> functional ones, in the same code lines?  Also, no.
>
> I prefer using common sense over black-and-white rules.
>
> If patch is a _really_ tiny one (<  20 LOC changed) it sometimes makes
> sense to save the time on handling separate patches.

This is open source -- you have to consider the time saved by reviewers too.

But I doubt you have saved time on all your motivated commit searches, so...

	Jeff



