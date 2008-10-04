From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/6] Hibernation: Introduce system_entering_hibernation
Date: Sun, 5 Oct 2008 00:30:17 +0200
Message-ID: <200810050030.18814.rjw@sisk.pl>
References: <200808290002.55026.rjw@sisk.pl> <20081004225008.2cc08201@lxorguk.ukuu.org.uk> <48E7E5B1.8010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <48E7E5B1.8010101@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Saturday, 4 of October 2008, Tejun Heo wrote:
> Alan Cox wrote:
> >> Hm, I'm not sure what you mean exactly, but the point is to blacklist the
> >> on-board controllers only and a devfn of the controller is needed for that,
> >> or a part of it (like the slot number I'm using).  Could that be done above
> >> the driver level?
> > 
> > It can be done in one place via the libata core code I think rather than
> > in each driver. Might need to be a helper function but you'd at least
> > remove all the duplication.
> 
> I think it's better to keep the list in each LLD but having a helper in
> libata-core would be nice.

Well, I can try to introduce one in a future patch.  Will that be OK?

Rafael
