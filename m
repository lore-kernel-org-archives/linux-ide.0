From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ATA/133 Problems with multiple cards
Date: Thu, 14 Oct 2004 21:31:54 +0200
Sender: kernelnewbies-bounce@nl.linux.org
Message-ID: <58cb370e04101412312fc42a57@mail.gmail.com>
References: <Pine.LNX.4.44.0410141710390.1681-100000@beast.stev.org>
	 <ckmfiq$rc7$1@sea.gmane.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kernelnewbies-bounce@nl.linux.org>
In-Reply-To: <ckmfiq$rc7$1@sea.gmane.org>
Errors-to: kernelnewbies-bounce@nl.linux.org
List-help: <mailto:ecartis@nl.linux.org?Subject=help>
List-unsubscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=unsubscribe>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=subscribe>
List-owner: <mailto:ecartis-owner@nl.linux.org>
List-post: <mailto:kernelnewbies@nl.linux.org>
List-archive: <http://mail.nl.linux.org/kernelnewbies/>
To: Ian Pilcher <i.pilcher@comcast.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
List-Id: linux-ide@vger.kernel.org

On Thu, 14 Oct 2004 13:12:42 -0500, Ian Pilcher <i.pilcher@comcast.net> wrote:
> James Stevenson wrote:
> >
> > i seem to have run into an annoying problem with a machine which has
> > 3 promise ata/133 card the PDC20269 type.
> >
> 
> ....
> 
> >
> > Does anyone have an explenation of why this can happen ?

* check power supply
* compare PCI config space of the "failing" controller to the one which
  is "working" (assuming that identical devices are connected to each),
  maybe firmware/driver forgets to setup some settings

> Promise cards don't support more than two per machine.  If you can get a
> third card to work in PIO mode, consider it an added (but unsupported)
> bonus.

AFAIR people have been running 4-5 cards just fine

--
Kernelnewbies: Help each other learn about the Linux kernel.
Archive:       http://mail.nl.linux.org/kernelnewbies/
FAQ:           http://kernelnewbies.org/faq/
