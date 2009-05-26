From: "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>
Subject: Re: [PATCH 1/3] ide: add "ignore_hpa" module parameter
Date: Tue, 26 May 2009 20:08:21 +0200
Message-ID: <20090526180821.GB13276@ub>
References: <200905252344.11826.bzolnier@gmail.com> <200905260106.13705.elendil@planet.nl> <200905261423.40117.bzolnier@gmail.com> <200905261453.22428.elendil@planet.nl> <20090526140132.19e8bc13@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756927AbZEZSIn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090526140132.19e8bc13@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Frans Pop <elendil@planet.nl>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, May 26, 2009 at 02:01:32PM +0100, Alan Cox wrote:
> > Naive thought: wouldn't it be possible to check whether a partition 
> > overlaps the HPA boundary and warn or even bug out in that case?
> 
> No - believe me we all thought about that. The PC partition format has
> starts but not ends so you need detailed internal file system knowledge
> to play guessing games (which thus needs to be user space). Some of the
> non PC formats use the middle or end of disk so if you don't know the
> size you can't *find* the partition data.
> 
> Alan

Hi Alan,

Probably I am missing some context, but the above seems to be
a false statement. The PC partition format does give you
start and size, and no filesystem knowledge is needed to
find out where a partition ends.

Andries
