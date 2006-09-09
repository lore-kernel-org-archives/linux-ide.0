From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.18-rc5-mm1
Date: Sat, 09 Sep 2006 16:47:18 -0700
Message-ID: <45035286.8070209@goop.org>
References: <20060901015818.42767813.akpm@osdl.org> <1157158847.20509.10.camel@mhcln03> <20060901183028.1c6da4df.akpm@osdl.org> <44F93EB3.8050500@goop.org> <44F942B9.6050102@goop.org> <20060902084440.GA13361@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20060902084440.GA13361@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Matthias Hentges <oe@hentges.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-ide@vger.kernel.org

Greg KH wrote:
> There are 9 MSI patches in my tree that you can just remove.  They were
> just recently (a few hours ago) replaced with a total rewrite due to a
> number of different problems that were found.  So I'd suggest just
> waiting till the next -mm release to see if it works properly or not.
>   

I'm seeing exactly the same oops with CONFIG_MSI on 2.6.18-rc6-mm1.

    J
