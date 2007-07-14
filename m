From: "Tuomas Leikola" <tuomas.leikola@gmail.com>
Subject: Re: [RFT][PATCH v7] sata_mv: convert to new EH
Date: Sat, 14 Jul 2007 13:00:56 +0300
Message-ID: <5b170a7d0707140300n45460db8rdc488cb9a1e77a4f@mail.gmail.com>
References: <20070711200538.GA7374@havoc.gtf.org>
	 <Pine.LNX.4.64.0707120212210.25837@twinlark.arctic.org>
	 <46960225.5000502@garzik.org>
	 <Pine.LNX.4.64.0707121140560.29365@twinlark.arctic.org>
	 <46967B3C.708@garzik.org>
	 <Pine.LNX.4.64.0707121323570.29365@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:5726 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbXGNKA7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jul 2007 06:00:59 -0400
Received: by wa-out-1112.google.com with SMTP id v27so893404wah
        for <linux-ide@vger.kernel.org>; Sat, 14 Jul 2007 03:00:59 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707121323570.29365@twinlark.arctic.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dean gaudet <dean@arctic.org>
Cc: linux-ide@vger.kernel.org

On 7/13/07, dean gaudet <dean@arctic.org> wrote:
> > I presume from your past messages your tests include multiple disks at the
> > same time?
>
> yep, 4 disks... i was getting 4x74MB/s with dd read.  unfortunately i
> don't have more disks in the system at this point so i can't test all 8
> ports at full tilt.
>
> each disk had its own XFS filesystem.
>

Just a sidenote, at some point (think 2.6.15) I had problems with
sata_mv that *only* occurred with md raid levels 1,5,6 - everything
was ok when multiple disks were separate filesystems. That was like 4
disks and 10 threads or so.

So I'd recommend always testing also with raid. I'll leave the
guessing about what might be reasons for that behaviour for others.
