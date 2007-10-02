From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version
 4
Date: Tue, 02 Oct 2007 17:23:17 -0400
Message-ID: <4702B6C5.2070903@garzik.org>
References: <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org> <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org> <46F33824.6000707@gmail.com> <20070924231436.GA32119@srcf.ucam.org> <47025E09.1030803@garzik.org> <20071002184958.GC31251@srcf.ucam.org> <47029423.6030605@garzik.org> <4702AC3B.2010004@garzik.org> <20071002212028.GA967@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20071002212028.GA967@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kristen.c.accardi@intel.com
List-Id: linux-ide@vger.kernel.org

Matthew Garrett wrote:
> Fix libata-acpi.c build failure.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> --- 
> 
> Sorry, I'd diffed the original against libata-dev master rather than 
> ALL. This tidies up the changes.

I had to yank the patch.  For bisect-ability, we really really want to 
avoid pushing patches upstream that don't build; so, please resend a 
fixed version.

BTW, you generally want to diff against libata-dev.git#upstream. 
'upstream' branch is always what is queued for the next kernel release. 
  'ALL' is a meta-branch that includes #upstream, but also other stuff 
we want in -mm for testing.

	Jeff



