From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: irq 10: nobody cared! (was: Re: 2.6.11-rc3-mm1)
Date: Sat, 5 Feb 2005 20:45:58 -0200
Message-ID: <20050205224558.GB3815@ime.usp.br>
References: <20050204103350.241a907a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Disposition: inline
In-Reply-To: <20050204103350.241a907a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
List-Id: linux-ide@vger.kernel.org

Dear developers,

=46or some kernel versions (say, since 2.6.10 proper, all the 2.6.11-rc=
's,
some -mm trees and also -ac) I have been getting the message "irq 10:
nobody cared!".

The message says that I should pass the irqpoll option to the kernel an=
d
even if I do, I still get the stack trace and the "irq 10: nobody cared=
!"
message. :-(

The message seems to be related to the Promise PDC20265 driver and it
appeared right after I moved my HDs from my motherboard's VIA controlle=
rs
to the Promise controllers. I have an Asus A7V board, with 2 VIA 686a
controllers and 2 Promise PDC20265 controllers.

I already tried enabling and disabling ACPI, but it seems that the prob=
lem
just doesn't go away. :-(

I am including the dmesg log of my system with this message. I am CC'in=
g
the linux-ide list, but I'm only subscribed to linux-kernel. I would
appreciate CC's, if possible.


Thank you very much for any help, Rog=E9rio.

P.S.: I am, right now, re-compiling 2.6.11-rc3-mm1 with the extra pass =
of
kallsyms to see if the problem persists with this release.
--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
  Rog=E9rio Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
