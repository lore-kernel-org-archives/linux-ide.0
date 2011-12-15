From: Lin Ming <ming.m.lin@intel.com>
Subject: [RFC][PATCH 4/4] ahci: support hot plug when port/controller is runtime suspended
Date: Thu, 15 Dec 2011 21:12:49 +0800
Message-ID: <1323954769-3918-5-git-send-email-ming.m.lin@intel.com>
References: <1323954769-3918-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323954769-3918-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Stern <stern@rowland.harvard.edu>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-ide@vger.kernel.org

This is an empty patch now :)

I use eSATA to test disk hot plug.
With previous 3 patches applied, disk hot plug does not wok
when ahci port/controller is runtime suspended.

There are 2 cases we need to handle for hot plug:

1. port suspended, controller active
   Is IRQ need to be enabled for port to detect hot plug? 

2. port suspended, controller suspended
   Will controller get a PME when hot plug happens?

I'm still investigating hot plug support.

Anyone has comment?

Thanks,
Lin Ming
