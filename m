From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: How to make SATA hotplug path tight?
Date: Fri, 15 Sep 2006 19:11:50 +0200
Message-ID: <c384c5ea0609151011o2995e8a4x1fa2d0ac1ef5074d@mail.gmail.com>
References: <8202f4270609150812r654c1319r511b18aadf7e1f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:23361 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932069AbWIORLv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Sep 2006 13:11:51 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1426938nzf
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2006 10:11:51 -0700 (PDT)
In-Reply-To: <8202f4270609150812r654c1319r511b18aadf7e1f7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

Fajun,

On 9/15/06, Fajun Chen <fajunchen@gmail.com> wrote:
> Hi,
>
> I'm trying to speed up the SATA hotplug sequence so I can measure the
> disk spinup time more accurately.  I noticed two delays which may be
>
Did you check whether the SMART attribute that indicates disk spin-up
time did suit your needs?

Regards,

Leon.
