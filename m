From: Nick Bowler <nbowler@elliptictech.com>
Subject: Re: T500 cdrom drive never stops spinning until mount.
Date: Thu, 13 May 2010 09:04:49 -0400
Message-ID: <20100513130448.GA1967@elliptictech.com>
References: <20100512023549.GA22623@cpu18.student.cs>
 <4BEB4FA3.70308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BEB4FA3.70308@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 19:02 Wed 12 May     , Robert Hancock wrote:
> Is something like hal, devicekit, etc. accessing the drive in this case? 
> Can you try a minimal boot with no unnecessary processes and see if the 
> same thing happens?

Good call, booting with init=/bin/zsh and sure enough, the cd drive
spins down.  Looks like udev is causing the constant spin-ups, so I'll
post to linux-hotplug instead.

Sorry for the noise,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
