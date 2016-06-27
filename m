From: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH] sparc64: sparc64_defconfig: convert to use libata PATA drivers
Date: Tue, 28 Jun 2016 09:18:59 +1000
Message-ID: <CAGRGNgUzCDkXvq3YvihUoh87NFNWOUnqCUbWMAa09oj8N2vskw@mail.gmail.com>
References: <1467030232-10027-1-git-send-email-b.zolnierkie@samsung.com> <6e328063b70b3fe60b4dd962c1616260@triadic.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35192 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbcF0XTc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2016 19:19:32 -0400
In-Reply-To: <6e328063b70b3fe60b4dd962c1616260@triadic.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alexmcwhirter@triadic.us
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux-owner@vger.kernel.org

Hi Alex,

On Tue, Jun 28, 2016 at 2:38 AM,  <alexmcwhirter@triadic.us> wrote:
> On 2016-06-27 08:23, Bartlomiej Zolnierkiewicz wrote:
>
>> If you have affected hardware please test.  Thank you.
>
>
> For what it's worth, I've been using libata on sparc64 for roughly two years
> with no issues to report. All of my PATA machines have ALI controllers, not
> sure if any other controllers were ever used in sparc gear.

The Ultra 5 uses a CMD64x controller.

That said, last time I tried to get that machine working, I couldn't
partition the disk due to bugs in that driver.

I believe the Ultra 10 uses the same motherboard so it's likely also
affected. I believe these were in the first generation of "PC" like
SPARC workstations.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
