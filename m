From: James Andrewartha <jamesa@daa.com.au>
Subject: Re: 2.6.33: libata issues with VIA SATA/PATA controller
Date: Fri, 09 Apr 2010 14:04:14 +0800
Message-ID: <4BBEC35E.8060002@daa.com.au>
References: <201004090436.o394a0ao022460@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201004090436.o394a0ao022460@turbo.physics.adelaide.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 9/04/2010 12:36 PM, Jonathan Woithe wrote:
> Hi Jeff
> 
>> A complete dmesg is definitely useful.
> 
> It's at the end of my previous post.
> 
>> Posting one from the failing kernel would be preferred, though.
> 
> Any ideas as to how I can capture it?  Since the SATA disc interfaces stop
> working long before they are mounted none of the early boot messages make it
> to disc.  All the interesting bits are therefore scrolled into the bit
> bucket.
> 
> A serial console might be doable (is there documentation about how to set
> one up?) but that would take some time to arrange - I'm only physically at
> the machine in question sporadically and I'd have to rustle up another PC
> ready for my next visit.  It could be done, but might take some time.

Netconsole is the easiest way to get dmesg when disks aren't working - see
Documentation/networking/netconsole.txt for details on how to set it up.

-- 
James Andrewartha
