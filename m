From: Tejun Heo <tj@kernel.org>
Subject: Re: Regression 3.2 -> 3.3-rc1 10 sec hang at boot and resume,
 COMRESET failed
Date: Mon, 13 Feb 2012 09:44:45 -0800
Message-ID: <20120213174445.GD12117@google.com>
References: <20120203054319.GA25510@gamma.logic.tuwien.ac.at>
 <1328257660.15079.30.camel@minggr>
 <20120206004608.GA9413@gamma.logic.tuwien.ac.at>
 <1328492218.15079.38.camel@minggr>
 <20120206024052.GI9413@gamma.logic.tuwien.ac.at>
 <1328496591.15079.40.camel@minggr>
 <20120206031528.GA16093@gamma.logic.tuwien.ac.at>
 <1328503376.15079.55.camel@minggr>
 <20120206161943.GA3926@google.com>
 <CAN8TOE9SM1X_rQCScE8hCZYrWVY9K-B_TM+Vvzx3tZQ2LoGxXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAN8TOE9SM1X_rQCScE8hCZYrWVY9K-B_TM+Vvzx3tZQ2LoGxXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Lin Ming <ming.m.lin@intel.com>, Norbert Preining <preining@logic.at>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, jeff@garzik.org, "stern@rowland.harvard.edu >> Alan Stern" <stern@rowland.harvard.edu>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jian Peng <jipeng2005@gmail.com>, Kevin Cernekee <cernekee@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Mon, Feb 06, 2012 at 11:20:45AM -0800, Brian Norris wrote:
> I see the following options:
> (1) implement a flag that can be passed through ahci_platform; this
> would not be very useful, as we would still have to tweak the driver
> out of tree.

Yeah, please add module param to make this behavior conditional.

> (2) Drop the fix entirely. This is a spec. violation, but we can
> simply try to maintain the fix out-of-tree.

Nothing is perfect and real hardware should come before spec.

Thanks.

-- 
tejun
