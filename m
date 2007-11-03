From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH]libata-acpi: add ACPI _PSx method
Date: Sat, 03 Nov 2007 09:00:53 -0400
Message-ID: <472C7105.8030804@pobox.com>
References: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>	 <1190341023.16930.5.camel@sli10-conroe.sh.intel.com>	 <200710302227.40310.lenb@kernel.org> <200710311426.25099.rjw@sisk.pl>	 <1193885429.6872.2.camel@sli10-conroe.sh.intel.com>	 <20071101100435.7c80785e@the-village.bc.nu> <1193967158.13603.4.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1193967158.13603.4.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Tejun Heo <htejun@gmail.com>, linux-ide <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

Shaohua Li wrote:
> Not sure, this is just to call a BIOS routine, but a check should be
> safer. Thanks!
> 
> ACPI spec (ver 3.0a, p289) requires IDE power on/off executes ACPI _PSx
> methods. As recently most PATA drivers use libata, this patch adds _PSx
> method support in libata. ACPI spec doesn't mention if SATA requires the
> same _PSx method.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> Acked-by: Len Brown <len.brown@intel.com>


What is the safety factor on this patch?  :)

Since we are into 2.6.24-rc, my preference would be to let this get some 
testing in -mm, and push it upstream for 2.6.25.  Comments?

	Jeff


