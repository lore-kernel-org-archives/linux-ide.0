From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: How to make SATA hotplug path tight?
Date: Fri, 15 Sep 2006 13:40:10 -0600
Message-ID: <8202f4270609151240v119a6465o313968e184189c36@mail.gmail.com>
References: <8202f4270609150812r654c1319r511b18aadf7e1f7@mail.gmail.com>
	 <c384c5ea0609151011o2995e8a4x1fa2d0ac1ef5074d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.239]:16983 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751514AbWIOTkL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Sep 2006 15:40:11 -0400
Received: by qb-out-0506.google.com with SMTP id p36so784876qba
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2006 12:40:11 -0700 (PDT)
In-Reply-To: <c384c5ea0609151011o2995e8a4x1fa2d0ac1ef5074d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

On 9/15/06, Leon Woestenberg <leon.woestenberg@gmail.com> wrote:
> Fajun,
>
> On 9/15/06, Fajun Chen <fajunchen@gmail.com> wrote:
> > Hi,
> >
> > I'm trying to speed up the SATA hotplug sequence so I can measure the
> > disk spinup time more accurately.  I noticed two delays which may be
> >
> Did you check whether the SMART attribute that indicates disk spin-up
> time did suit your needs?
>
Leon, I need to measure this in software to make sure interface is
ready while SMART attributes spinup time may have some uncertainty.
