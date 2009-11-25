From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 19/86] pata_cmd640: document known issues
Date: Wed, 25 Nov 2009 12:37:19 -0500
Message-ID: <4B0D6B4F.9030605@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost>	<20091125170436.5446.83994.sendpatchset@localhost> <20091125172633.7a15711b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759271AbZKYRhX@vger.kernel.org>
In-Reply-To: <20091125172633.7a15711b@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 11/25/2009 12:26 PM, Alan Cox wrote:
> On Wed, 25 Nov 2009 18:04:36 +0100
> Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>  wrote:
>
>> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
>> Subject: [PATCH] pata_cmd640: document known issues
>>
>> Document known issues with the driver to aid distribution makers,
>> users and developers in making informed decisions instead of wasting
>> their time needlessly.
>
> Umm. its a) under CONFIG_PCI, and b) says CMD640 PCI IDE...

Agreed, that's a bit redundant.

Also, as I noted in another email, known issues should be listed in the 
driver source code at the top of the file, not in Kconfig.

That way the list of known issues actually follows the implementation, 
as the source code is copied around various kernel trees.

	Jeff
