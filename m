From: Hans-Peter Jansen <hpj@urpla.net>
Subject: Re: ATA/133 Problems with multiple cards
Date: Thu, 21 Oct 2004 22:00:35 +0200
Sender: kernelnewbies-bounce@nl.linux.org
Message-ID: <200410212200.35037.hpj@urpla.net>
References: <Pine.LNX.4.44.0410201211481.5805-100000@beast.stev.org> <200410201623.21321.hpj@urpla.net> <58cb370e041021114374bb749f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kernelnewbies-bounce@nl.linux.org>
In-Reply-To: <58cb370e041021114374bb749f@mail.gmail.com>
Content-Disposition: inline
Errors-to: kernelnewbies-bounce@nl.linux.org
List-help: <mailto:ecartis@nl.linux.org?Subject=help>
List-unsubscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=unsubscribe>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=subscribe>
List-owner: <mailto:ecartis-owner@nl.linux.org>
List-post: <mailto:kernelnewbies@nl.linux.org>
List-archive: <http://mail.nl.linux.org/kernelnewbies/>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: James Stevenson <james@stev.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
List-Id: linux-ide@vger.kernel.org

On Thursday 21 October 2004 20:43, Bartlomiej Zolnierkiewicz wrote:
> On Wed, 20 Oct 2004 16:23:21 +0200, Hans-Peter Jansen 
<hpj@urpla.net> wrote:
> > Hmm, I'm running 3 TX2/100 (even with different revisions)
> > without big problems here:
> >
> > 00:09.0 Unknown mass storage controller: Promise Technology, Inc.
> > 20268 (rev 02) 00:0a.0 Unknown mass storage controller: Promise
> > Technology, Inc. 20268 (rev 02) 00:0b.0 Unknown mass storage
> > controller: Promise Technology, Inc. 20268 (rev 01)
>
> lspci -xxx ?

With pleasure. Let me know, if I can provide anything else useful.
BTW, Bart, I suspect James' problem is, that his system is running in 
pic mode, while mine is in apic mode.

00:09.0 Unknown mass storage controller: Promise Technology, Inc. 
20268 (rev 02)
00: 5a 10 68 4d 07 00 30 04 02 85 80 01 08 40 00 00
10: 01 ec 00 00 01 e8 00 00 01 e4 00 00 01 e0 00 00
20: 01 dc 00 00 00 c0 ff df 00 00 00 00 5a 10 68 4d
30: 01 00 fe df 60 00 00 00 00 00 00 00 0a 01 04 12
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 21 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 
20268 (rev 02)
00: 5a 10 68 4d 07 00 30 04 02 85 80 01 08 40 00 00
10: 01 c4 00 00 01 c0 00 00 01 bc 00 00 01 b8 00 00
20: 01 b4 00 00 00 80 ff df 00 00 00 00 5a 10 68 4d
30: 01 00 fd df 60 00 00 00 00 00 00 00 09 01 04 12
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 21 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 
20268 (rev 01)
00: 5a 10 68 4d 07 00 30 04 01 85 80 01 08 40 00 00
10: 01 b0 00 00 01 ac 00 00 01 a8 00 00 01 a4 00 00
20: 01 a0 00 00 00 40 ff df 00 00 00 00 5a 10 68 4d
30: 01 00 fb df 60 00 00 00 00 00 00 00 05 01 04 12
40: 80 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 01 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--
Kernelnewbies: Help each other learn about the Linux kernel.
Archive:       http://mail.nl.linux.org/kernelnewbies/
FAQ:           http://kernelnewbies.org/faq/
