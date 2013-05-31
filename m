From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c-piix4: add AMD CZ SMBus device ID
Date: Fri, 31 May 2013 09:28:46 +0200
Message-ID: <20130531092846.51f2e202@endymion.delvare>
References: <1369999333-2073-1-git-send-email-shane.huang@amd.com>
	<20130531080336.04481330@endymion.delvare>
	<43EB3AB3EEFE8D43B525F4D2EAF507E1085B8CC5@SCYBEXDAG04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E1085B8CC5-7mPiUsE5EJ9oz6IQsZflRkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Huang, Shane" <Shane.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Fri, 31 May 2013 06:42:54 +0000, Huang, Shane wrote:
> Hi Jean,
> 
> > Please don't change the case. This makes your patch larger and
> > increases the risk of conflict with other patches, for no good reason.
> > 
> > Other than that, the patch looks OK.
> 
> I didn't want to change it but checkpatch.pl warns due to
> "Hudson-2" in i2c-piix4.c

Can you show the exact message? checkpatch doesn't complain here, and I
can't think of any reason why it would care about that.

-- 
Jean Delvare
