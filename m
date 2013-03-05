From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH #upstream] libata: export local port number through /sys
Date: Tue, 05 Mar 2013 16:48:32 +0100
Message-ID: <513613D0.9090904@suse.de>
References: <1359049929-17069-1-git-send-email-dmilburn@redhat.com> <512BD1DA.80305@redhat.com> <CAPXgP13Q3TyWPwE3CqhiqouLQH-oyr8EC=wHChy50he74qokug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47128 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753098Ab3CEPse (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Mar 2013 10:48:34 -0500
In-Reply-To: <CAPXgP13Q3TyWPwE3CqhiqouLQH-oyr8EC=wHChy50he74qokug@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay@vrfy.org>
Cc: David Milburn <dmilburn@redhat.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

On 02/26/2013 04:26 PM, Kay Sievers wrote:
> On Mon, Feb 25, 2013 at 10:04 PM, David Milburn <dmilburn@redhat.com>=
 wrote:
>> David Milburn wrote:
>>>
>>> Export <global port>.<local port> format through /sys
>>>
>>> ./pci0000:00/0000:00:1f.2/ata1.1
>>> ./pci0000:00/0000:00:1f.2/ata1.1/link1.1/dev1.1.0/ata_device
>>> ./pci0000:00/0000:00:1f.2/ata1.1/link1.1/ata_link
>>> ./pci0000:00/0000:00:1f.2/ata1.1/ata_port
>>> ./pci0000:00/0000:00:1f.2/ata1.1/ata_port/ata1.1
>>> ./pci0000:00/0000:00:1f.2/ata2.2
>>> ./pci0000:00/0000:00:1f.2/ata2.2/link2.2/dev2.2.0/ata_device
>>> ./pci0000:00/0000:00:1f.2/ata2.2/link2.2/ata_link
>>> ./pci0000:00/0000:00:1f.2/ata2.2/ata_port
>>> ./pci0000:00/0000:00:1f.2/ata2.2/ata_port/ata2.2
>>> ./pci0000:00/0000:00:1f.2/ata3.3
>>> ./pci0000:00/0000:00:1f.2/ata3.3/link3.3/dev3.3.0/ata_device
>>> ./pci0000:00/0000:00:1f.2/ata3.3/link3.3/ata_link
>>> ./pci0000:00/0000:00:1f.2/ata3.3/ata_port
>>> ./pci0000:00/0000:00:1f.2/ata3.3/ata_port/ata3.3
>>> ./pci0000:00/0000:00:1f.2/ata4.4
>>> ./pci0000:00/0000:00:1f.2/ata4.4/link4.4/dev4.4.0/ata_device
>>> ./pci0000:00/0000:00:1f.2/ata4.4/link4.4/ata_link
>>> ./pci0000:00/0000:00:1f.2/ata4.4/ata_port
>>> ./pci0000:00/0000:00:1f.2/ata4.4/ata_port/ata4.4
>>> ./pci0000:00/0000:00:1f.2/ata5.5
>>> ./pci0000:00/0000:00:1f.2/ata5.5/link5.5/dev5.5.0/ata_device
>>> ./pci0000:00/0000:00:1f.2/ata5.5/link5.5/ata_link
>>> ./pci0000:00/0000:00:1f.2/ata5.5/ata_port
>>> ./pci0000:00/0000:00:1f.2/ata5.5/ata_port/ata5.5
>>> ./pci0000:00/0000:00:1f.2/ata6.6
>>> ./pci0000:00/0000:00:1f.2/ata6.6/link6.6/dev6.6.0/ata_device
>>> ./pci0000:00/0000:00:1f.2/ata6.6/link6.6/ata_link
>>> ./pci0000:00/0000:00:1f.2/ata6.6/ata_port
>>> ./pci0000:00/0000:00:1f.2/ata6.6/ata_port/ata6.6
>>>
Hmm.

Can't say I like the 'global port' notation.
Personally I would prefer to have a sysfs attribute for the local=20
port number, and have path_id get it from there.

=46or 95% of all cases the above is just an information duplication=20
(ie it'll only provide a real value for udev, but not for the user).

So, please, use a sysfs attribute for the local port and keep the=20
numbering as it is.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: J. Hawn, J. Guild, F. Imend=C3=B6rffer, HRB 16746 (AG N=C3=BCrnberg=
)
