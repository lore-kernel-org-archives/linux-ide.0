From: Nick Bowler <nbowler@elliptictech.com>
Subject: Re: T500 cdrom drive never stops spinning until mount.
Date: Wed, 12 May 2010 09:19:12 -0400
Message-ID: <20100512131912.GA27273@elliptictech.com>
References: <20100512023549.GA22623@cpu18.student.cs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100512023549.GA22623@cpu18.student.cs>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 22:35 Tue 11 May     , Nick Bowler wrote:
> Mounting the disk also causes it to stop spinning (and it remains
> stopped after unmounting it).

Sorry, this was a lie.  As soon as the disk spins up again after
unmounting (or if it was unmounted while still spinning), it will
continue to spin forever.

-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
