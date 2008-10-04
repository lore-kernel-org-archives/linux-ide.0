From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/6] Hibernation: Introduce system_entering_hibernation
Date: Sat, 4 Oct 2008 22:50:08 +0100
Message-ID: <20081004225008.2cc08201@lxorguk.ukuu.org.uk>
References: <200808290002.55026.rjw@sisk.pl>
	<200810032351.46869.rjw@sisk.pl>
	<20081004002724.47fab174@lxorguk.ukuu.org.uk>
	<200810041213.22249.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200810041213.22249.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-ide@vger.kernel.org

> Hm, I'm not sure what you mean exactly, but the point is to blacklist the
> on-board controllers only and a devfn of the controller is needed for that,
> or a part of it (like the slot number I'm using).  Could that be done above
> the driver level?

It can be done in one place via the libata core code I think rather than
in each driver. Might need to be a helper function but you'd at least
remove all the duplication.

Alan
