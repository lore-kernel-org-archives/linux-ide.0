From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: ata_piix can't drive Mac hardware properly
Date: Wed, 28 Mar 2007 02:16:09 +0100
Message-ID: <20070328011608.GA26913@srcf.ucam.org>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk> <20070328000851.GA25551@srcf.ucam.org> <20070328001610.GB25551@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965555AbXC1BQW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070328001610.GB25551@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 28, 2007 at 01:16:10AM +0100, Matthew Garrett wrote:

> comment seems to be wrong (or, alternatively, it's the 
> ata_read_native_max_address_ext call that's failing and returning 
> garbage? I'll look into that)

It's ata_read_native_max_address_ext failing, and it's fine if I use 
ahci rather than ata_piix, so I'll just chalk this up to Apple's 
firmware being broken (again) and putting the hardware into some sort of 
"I can't believe it's not piix" mode and see what I can do about 
ensuring we use ahci instead.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
