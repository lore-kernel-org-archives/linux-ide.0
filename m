From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH #upstream] libata: export local port number through /sys
Date: Wed, 06 Mar 2013 08:10:39 +0100
Message-ID: <5136EBEF.7070303@suse.de>
References: <1359049929-17069-1-git-send-email-dmilburn@redhat.com> <512BD1DA.80305@redhat.com> <CAPXgP13Q3TyWPwE3CqhiqouLQH-oyr8EC=wHChy50he74qokug@mail.gmail.com> <513613D0.9090904@suse.de> <20130305230430.GA14118@dhcp-10-15-1-70.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50580 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab3CFHKo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Mar 2013 02:10:44 -0500
In-Reply-To: <20130305230430.GA14118@dhcp-10-15-1-70.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, kay@vrfy.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

On 03/06/2013 12:04 AM, David Milburn wrote:
> On Tue, Mar 05, 2013 at 04:48:32PM +0100, Hannes Reinecke wrote:
>> On 02/26/2013 04:26 PM, Kay Sievers wrote:
>>> On Mon, Feb 25, 2013 at 10:04 PM, David Milburn <dmilburn@redhat.co=
m>
>>> wrote:
>>>> David Milburn wrote:
>>>>>
>>>>> Export <global port>.<local port> format through /sys
>>>>>
>>>>> ./pci0000:00/0000:00:1f.2/ata1.1
>>>>> ./pci0000:00/0000:00:1f.2/ata1.1/link1.1/dev1.1.0/ata_device
>>>>> ./pci0000:00/0000:00:1f.2/ata1.1/link1.1/ata_link
>>>>> ./pci0000:00/0000:00:1f.2/ata1.1/ata_port
>>>>> ./pci0000:00/0000:00:1f.2/ata1.1/ata_port/ata1.1
>>>>> ./pci0000:00/0000:00:1f.2/ata2.2
>>>>> ./pci0000:00/0000:00:1f.2/ata2.2/link2.2/dev2.2.0/ata_device
>>>>> ./pci0000:00/0000:00:1f.2/ata2.2/link2.2/ata_link
>>>>> ./pci0000:00/0000:00:1f.2/ata2.2/ata_port
>>>>> ./pci0000:00/0000:00:1f.2/ata2.2/ata_port/ata2.2
>>>>> ./pci0000:00/0000:00:1f.2/ata3.3
>>>>> ./pci0000:00/0000:00:1f.2/ata3.3/link3.3/dev3.3.0/ata_device
>>>>> ./pci0000:00/0000:00:1f.2/ata3.3/link3.3/ata_link
>>>>> ./pci0000:00/0000:00:1f.2/ata3.3/ata_port
>>>>> ./pci0000:00/0000:00:1f.2/ata3.3/ata_port/ata3.3
>>>>> ./pci0000:00/0000:00:1f.2/ata4.4
>>>>> ./pci0000:00/0000:00:1f.2/ata4.4/link4.4/dev4.4.0/ata_device
>>>>> ./pci0000:00/0000:00:1f.2/ata4.4/link4.4/ata_link
>>>>> ./pci0000:00/0000:00:1f.2/ata4.4/ata_port
>>>>> ./pci0000:00/0000:00:1f.2/ata4.4/ata_port/ata4.4
>>>>> ./pci0000:00/0000:00:1f.2/ata5.5
>>>>> ./pci0000:00/0000:00:1f.2/ata5.5/link5.5/dev5.5.0/ata_device
>>>>> ./pci0000:00/0000:00:1f.2/ata5.5/link5.5/ata_link
>>>>> ./pci0000:00/0000:00:1f.2/ata5.5/ata_port
>>>>> ./pci0000:00/0000:00:1f.2/ata5.5/ata_port/ata5.5
>>>>> ./pci0000:00/0000:00:1f.2/ata6.6
>>>>> ./pci0000:00/0000:00:1f.2/ata6.6/link6.6/dev6.6.0/ata_device
>>>>> ./pci0000:00/0000:00:1f.2/ata6.6/link6.6/ata_link
>>>>> ./pci0000:00/0000:00:1f.2/ata6.6/ata_port
>>>>> ./pci0000:00/0000:00:1f.2/ata6.6/ata_port/ata6.6
>>>>>
>> Hmm.
>>
>> Can't say I like the 'global port' notation.
>> Personally I would prefer to have a sysfs attribute for the local
>> port number, and have path_id get it from there.
>>
>> For 95% of all cases the above is just an information duplication
>> (ie it'll only provide a real value for udev, but not for the user).
>>
>> So, please, use a sysfs attribute for the local port and keep the
>> numbering as it is.
>
> Hi Hannes,
>
> Thanks for your feedback.
>
> Would this patch be acceptable to everyone?
>
I would prefer having it named 'port_no' instead of 'local_port_no'.
Other than that the patch is exactly what I had in mind.

Thanks.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
