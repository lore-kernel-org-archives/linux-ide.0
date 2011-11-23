From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Crash with sata_sil24 driver
Date: Wed, 23 Nov 2011 18:01:34 +0000
Message-ID: <20111123180134.GJ9581@n2100.arm.linux.org.uk>
References: <CAHM4w1kc+5aYWH-09BPTXZdo8+iguFjORKs7mMhG7hea2UU8yQ@mail.gmail.com> <CAHM4w1nZ7GgutiuDiTCKu9wUuphn8qOiWgmCYVXXvwW1q8CgoA@mail.gmail.com> <20111122150613.GA322@google.com> <CAHM4w1nsNTQmAL-0d76O9cYXjNbiq-0f60Y3emWO2yf7HyFWDg@mail.gmail.com> <20111123162937.GF25780@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111123162937.GF25780@google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Pratyush Anand <pratyush.anand@gmail.com>, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Nov 23, 2011 at 08:29:37AM -0800, Tejun Heo wrote:
> On Wed, Nov 23, 2011 at 10:49:00AM +0530, Pratyush Anand wrote:
> > On Tue, Nov 22, 2011 at 8:36 PM, Tejun Heo <tj@kernel.org> wrote:
> > > On Tue, Nov 22, 2011 at 04:40:40PM +0530, Pratyush Anand wrote:
> > >> > My question is.
> > >> > does sil24_init_controller insure perfact initilization?
> > >> > or we missing to check some status register which might be nee=
ded
> > >> > before ata_host_activate.
> > >> > --------------------------------------------------------------=
-------
> > >> > Modules linked in:
> > >> > CPU: 0 =A0 =A0Not tainted =A0(2.6.37-lsp-3.2.2-rc-dirty #7)
> > >> > PC is at sil24_scr_read+0x38/0x50
> > >> > LR is at sil24_port_base+0x14/0x2c
> > >> > pc : [<80255e10>] =A0 =A0lr : [<80255d44>] =A0 =A0psr: 8000001=
3

It would help if the _full_ set of kernel crash messages were included.
This one has the top chopped off it which normally says _why_ it happen=
ed.
I'm not about to waste my time by guessing...

Please provide the _full_ crash log, including the lines which come bef=
ore
"Modules linked in:"

And no, pci_iomap is not asynchronous.  That'd just be damned stupid an=
d
would break virtually all drivers.
