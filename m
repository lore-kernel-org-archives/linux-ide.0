From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [git patches] libata fixes for 3.7
Date: Tue, 02 Oct 2012 23:44:04 +0400
Message-ID: <506B4404.20100@msgid.tls.msk.ru>
References: <20121002194053.GA11100@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121002194053.GA11100@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 02.10.2012 23:40, Jeff Garzik wrote:

> Minor libata updates, nothing notable.
> 
> 1) Apply -- and then revert -- the FUA feature.  Caused
>    disk corruption in linux-next, proving it cannot be turned on by
>    default.

Any details on that?  Disk corruprion is rather a nasty
side-effect indeed.

Thank you!

/mjt
