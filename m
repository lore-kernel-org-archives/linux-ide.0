From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 15:02:13 +0100
Message-ID: <20080529140213.GA23373@srcf.ucam.org>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org> <483EB33D.6010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757272AbYE2OCr@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <483EB33D.6010101@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

On Thu, May 29, 2008 at 10:44:29PM +0900, Tejun Heo wrote:
> Does this fix the problem?

No, I'm seeing an identical hang. Mainline works fine.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
