From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: kernel BUG at drivers/ide/ide-disk.c:187 (2.6.31)
Date: Thu, 1 Oct 2009 20:21:24 +0200
Message-ID: <200910012021.24260.bzolnier@gmail.com>
References: <200910011026.17510.elendil@planet.nl> <200910011125.40081.bzolnier@gmail.com> <20091001.094034.161463891.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756088AbZJASU0@vger.kernel.org>
In-Reply-To: <20091001.094034.161463891.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: elendil@planet.nl, manty@manty.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 01 October 2009 18:40:34 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Thu, 1 Oct 2009 11:25:40 +0200
> 
> > The problem is that you simply cannot know what is the system state here.
> > 
> > Thus when the unknown block layer request is encountered the best thing
> > you can do is to BUG early instead of allowing the situation when some
> > requests are silently dropped and possibly causing the data corruption.
> 
> Yes, but if you BUG() in this kind of location, the chance of getting
> the debugging information from the user can be close to zero.  We were
> very lucky this time :-)

Do you mean that there is higher chance of user noticing some WARN_ON
warning somewhere in the log than OOPS?  I don't quite believe it..

> If we're tossing a request, signal an error to the submitter.
> 
> I hear we have infrastructure for that :-)

It has its own problems (see blk_execute_rq() overriding error values
for one of many examples)..

Anyway this is completely besides the point here (however please don't
let it stop you from fixing the aforementioned infrastructure) until
the whole issue gets debugged properly and I'd be quite happy to do it
under normal circumstances but since:

- you are always jumping the gun with your strong opinions before people
  even had chance to debug the issue properly and find real root causes
  (vide infamous sparc cmd64x problems, which were caused by the real
   bugfixes and were completely fixed within 48h from the initial report)

- for the last three months you haven't debugged/fixed a single IDE issue
  and you keep dodging every single bug-report 

- I have neither time nor interest for this kind of silly corporate-style
  games (I had some really good laugh few times though :)

- I really do not have to work on IDE (never had, it was always a hobby)

- I'm not the maintainer any longer :)

I simply do not even want to be cc:ed on IDE problems unless it is a paid
job or mail comes from the person who in the past proved the ability to
work well with others.

Thank you for understanding.
