From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] ide: add "ignore_hpa" module parameter
Date: Wed, 27 May 2009 13:41:52 +0200
Message-ID: <200905271341.52268.bzolnier@gmail.com>
References: <200905252344.11826.bzolnier@gmail.com> <200905261915.47212.bzolnier@gmail.com> <20090527113857.2a30e9d7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761881AbZE0LiJ@vger.kernel.org>
In-Reply-To: <20090527113857.2a30e9d7@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 27 May 2009 12:38:57 Alan Cox wrote:
> > All information was there (kernel logs).
> > 
> > Moreover the default in libata is to not remove HPA settings.
> > 
> > I don't recommend parsing kernels logs in search of such information but
> > you're are stretching the reality too far to match with your arguments.
> 
> So you disagree that sysfs is needed and propose an alternative that you
> say you don't recommend (and which doesn't solve the block problem).

This is not what I said (if this is a straw man attempt, please don't do it).

> I used to work for a distro, and telling Bill Nottingham that the
> reliable long term way for Fedora to obtain some interface data was by
> grepping dmesg wouldn't have gone down well.

Knowing the severity of accidentally removing data from HPA (which you
described yourself in the other mail) and also not being able to access
valid data from HPA (bug #13365) I would simply use in the installer
the alternative [*] (that I *don't* recommend as the long-term solution)
and then start working on adding proper sysyfs kernel interfaces (that
I *don't* consider not needed) and proper installer support.

[*] it would of course require passing "libata.ignore_hpa=1" to kernel
    during installation time

This would result in much less hassle for users, much less support costs
for distribution and having proper in-kernel / installer support faster
than doing it the non-pragmatic way (since we would save a lot of time on
handling bug-reports and discussions like this one).
