From: James Stevenson <james@stev.org>
Subject: Re: ATA/133 Problems with multiple cards
Date: Wed, 20 Oct 2004 12:18:02 +0100 (BST)
Sender: kernelnewbies-bounce@nl.linux.org
Message-ID: <Pine.LNX.4.44.0410201211481.5805-100000@beast.stev.org>
References: <200410201235.37423.hpj@urpla.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernelnewbies-bounce@nl.linux.org>
In-Reply-To: <200410201235.37423.hpj@urpla.net>
Errors-to: kernelnewbies-bounce@nl.linux.org
List-help: <mailto:ecartis@nl.linux.org?Subject=help>
List-unsubscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=unsubscribe>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=subscribe>
List-owner: <mailto:ecartis-owner@nl.linux.org>
List-post: <mailto:kernelnewbies@nl.linux.org>
List-archive: <http://mail.nl.linux.org/kernelnewbies/>
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org, James Stevenson <james@stev.org>
List-Id: linux-ide@vger.kernel.org

On Wed, 20 Oct 2004, Hans-Peter Jansen wrote:

> [Heavily stripped address lists]
> 
> On Sunday 17 October 2004 04:51, James Stevenson wrote:
> >
> > then i can only turn the dma up to ATA/100 if i set it to ata/133
> > it will cause the errors. I assume this is something todo with the
> > promise bois not setting up the 3rd card at boot time. It only
> > shows drive listing for 2 of the 3 cards.
> 
> As noted before, this effect was always related to different firmware 
> versions on the cards here. Please check boot messages of all cards 
> separately, and confirm, that this isn't your problem.

I had them all flashed to the latest current version which was 2.20.0.15
when i started having problems. Each card was verified to that version as 
well. Some did have older firmware on them.

The same problems were seen before / after flashign the card. As far as i 
could tell the promise bios will run form the first card and init the 
other cards it could be configuring something there which nobody else is 
aware of. However this only showed drives / drive interfaces form the 
first 2 cards never the 3rd card. After the bios has init'ed the carss 
the bios doesnt run on any other cards.

When booting the machine will 3 cards and no drives attached the bios is 
loaded and unloaded 3 times. This is why i belave something is getting 
enable / disabled on the other cards by the bios.

	James


-- 
--------------------------
Mobile: +44 07779080838
http://www.stev.org
 12:10pm  up 19:08,  5 users,  load average: 3.90, 3.83, 3.49


--
Kernelnewbies: Help each other learn about the Linux kernel.
Archive:       http://mail.nl.linux.org/kernelnewbies/
FAQ:           http://kernelnewbies.org/faq/
