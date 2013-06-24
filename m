From: Zdenek Kaspar <zkaspar82@gmail.com>
Subject: Re: SATA hdd refuses to reallocate a sector?
Date: Mon, 24 Jun 2013 14:48:56 +0200
Message-ID: <51C84038.6090507@gmail.com>
References: <20130623101940.GA4448@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130623101940.GA4448@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 06/23/2013 12:19 PM, Pavel Machek wrote:
> Hi!
> 
> This may very well be hw problem, but...
> 
> I have error on sda4. I tried to make hdd reallocate it by writing
> zeros there, but it will not. Is there special kind of write that
> needs to be done to force reallocation?

Hi Pavel, maybe smartctl -t long /dev/sda will do the trick reliable for
your drive..

Z.
