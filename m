From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug -
	version 3
Date: Thu, 27 Sep 2007 17:39:20 -0300
Message-ID: <20070927203920.GB28510@khazad-dum.debian.net>
References: <46F32DD9.7010509@gmail.com> <20070921024214.GA6317@srcf.ucam.org> <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org> <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org> <46F33824.6000707@gmail.com> <20070924231436.GA32119@srcf.ucam.org> <20070927102659.2cacae14.kristen.c.accardi@intel.com> <20070927175505.GA14476@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070927175505.GA14476@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

On Thu, 27 Sep 2007, Matthew Garrett wrote:
> The spec seems to imply that even if the drive hotswap bay and the 
> battery bay are physically the same, they're logically distinct. 10.2.1 

That holds true for thinkpads up to the T43, at least.  I don't know about
the newer ones.

You get bay ejects/inserts notifications from the device node corresponding
to what was inserted/removed from the multi-purpose bay.

> I /suspect/ that _STA on the bay device won't return true if there's a 
> battery in there, and so we aren't expected to call the _EJ0 method if 

Correct, on thinkpads up to the T43 at least.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
