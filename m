From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: pata sc1200 fix crash boot, bug #14227
Date: Fri, 23 Oct 2009 14:25:41 -0400
Message-ID: <4AE1F525.5090207@pobox.com>
References: <4AE1F29B.1090009@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752752AbZJWSZp@vger.kernel.org>
In-Reply-To: <4AE1F29B.1090009@computer.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Ceuleers <jan.ceuleers@computer.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg KH <greg@kroah.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, stable@kernel.org
List-Id: linux-ide@vger.kernel.org

On 10/23/2009 02:14 PM, Jan Ceuleers wrote:
> A little while ago [1], a fix was posted here for a boot-time crash in the sc1200 module.
>
> [1]: http://marc.info/?l=linux-kernel&m=125484259025909&w=2
>
> Submission to stable was also briefly discussed, but has apparently not happened, despite the fact that this bug appears to have existed since 2.6.29.
>
> I would therefore like to request that this fix now be submitted to stable.

Looks like commit 6d4f950e9ea15816c6a4f266ce6b9e438346771e is missing 
the "CC:stable@kernel.org".  Added implicitly via this message...
