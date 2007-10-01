From: "Michal Suchanek" <hramrach@centrum.cz>
Subject: Re: Maxtor 6L200M0 sata irq timeouts
Date: Mon, 1 Oct 2007 22:21:35 +0200
Message-ID: <a5d587fb0710011321w6ac7506cm81e917fcfa1fb7ca@mail.gmail.com>
References: <a5d587fb0709090234x1942e987u4187bf0dbe977a06@mail.gmail.com>
	 <6b9952490709090740t188d5b71x26b90421bfe948bf@mail.gmail.com>
	 <a5d587fb0709090920y1241a528x4f5a1141026256a7@mail.gmail.com>
	 <46E473D2.20907@gmail.com>
	 <a5d587fb0709100711s16a6df24i8fac5693c5cc8952@mail.gmail.com>
	 <46E5F15A.2090803@gmail.com>
	 <a5d587fb0709110429j6ce52fb2wb1d558281b36f8a7@mail.gmail.com>
	 <46FB56EF.8050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:34520 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbXJAUVi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 16:21:38 -0400
Received: by nf-out-0910.google.com with SMTP id g13so3044607nfb
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 13:21:36 -0700 (PDT)
In-Reply-To: <46FB56EF.8050703@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Joris <joris@v5.be>, linux-ide@vger.kernel.org

Hello

(please CC me when replying)

On 27/09/2007, Tejun Heo <htejun@gmail.com> wrote:
> Michal Suchanek wrote:
> > On 11/09/2007, Tejun Heo <htejun@gmail.com> wrote:
> >> Michal Suchanek wrote:
> >>>> What does 'smartctl -a /dev/sda' say?
> >>>>
> >>> Attaching output.
> >> Hmmm... How often does the condition occur?  smartlog records only two
> >> occasions.
> >>
> >
> > Every few minutes when the system is under load, less often when not.
> >
> > I think the logged drive errors are unrelated, the drive delivers the
> > interrupt, just a bit later than Linux expects. At least that is my
> > impression after looking at the these logs and the logs from the old
> > system (I am not sure I could still find the saved logs but with some
> > combination of irq related kernel options I got spurious interrupt
> > instead of timeout, and the drive got disabled).
>
> Can you please test the latest rc kernel and see whether this problem is
> still there?
>

With  2.6.23-rc8 I can still reproduce the problem.

I have moved the system to a pata drive and I am going to try and
replace the drive to get rid of both this interrupt stuff and
overheating.

Thanks

Michal
