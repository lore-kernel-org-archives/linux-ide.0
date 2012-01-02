From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH 4/4] ahci: support hot plug when port/controller
 is runtime suspended
Date: Mon, 2 Jan 2012 15:57:11 +0000
Message-ID: <20120102155711.GA10202@srcf.ucam.org>
References: <1323954769-3918-1-git-send-email-ming.m.lin@intel.com>
 <1323954769-3918-5-git-send-email-ming.m.lin@intel.com>
 <20111215192131.GE32002@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111215192131.GE32002@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Lin Ming <ming.m.lin@intel.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, kay.sievers@vrfy.org
List-Id: linux-ide@vger.kernel.org

On Thu, Dec 15, 2011 at 11:21:31AM -0800, Tejun Heo wrote:

> SATA link detection requires hot wire and keeping wire hot takes
> power.  I think it's fair tradeoff to not support hotplug while
> powersaving is on.  We have warm plug mechanism (the SCSI rescan
> trigger via sysfs) after all.  It would be nice if things like that is
> somehow exported to userland in easy way tho (cc'ing Kay), but I
> frankly don't have much idea where that would fit.

We expose the ahci_port_cmd field in sysfs, which lets us know whether a 
port is flagged as hotpluggable or external. Userspace could use that to 
identify whether a given port can be safely powered off or not. It's not 
guaranteed - desktop boards with esata ports will typically not have 
this information available (because the esata port could be plugged into 
any on-board port), so I think leaving it up to userspace to set the 
policy makes sense.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
