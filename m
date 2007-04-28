From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 06/13] libata-acpi: clean up parameters and misc stuff
Date: Sat, 28 Apr 2007 14:55:48 -0400
Message-ID: <463398B4.1010004@garzik.org>
References: <11772636663949-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11772636663949-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch cleans up libata-acpi such that it looks similar to other
> libata files.  This patch doesn't introuce any behavior changes.
> 
> * make libata-acpi functions take ata_device instead of ata_port +
>   device index
> * s/atadev/adev/
> * de-indent local variable declarations

I prefer 'dev' over 'adev', unless that makes the code in question more 
ambiguous.

Otherwise, ACK


