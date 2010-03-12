From: Jeff Garzik <jeff@garzik.org>
Subject: Re: CHS to LBA mapping for SCSI 6/10/12/16 byte RW CDB
Date: Fri, 12 Mar 2010 08:21:24 -0500
Message-ID: <4B9A3FD4.1020905@garzik.org>
References: <9edb119c1003120346r34c1c145t2be07595f9b151c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40594 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932750Ab0CLNV1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Mar 2010 08:21:27 -0500
Received: by pvg7 with SMTP id 7so71934pvg.19
        for <linux-ide@vger.kernel.org>; Fri, 12 Mar 2010 05:21:26 -0800 (PST)
In-Reply-To: <9edb119c1003120346r34c1c145t2be07595f9b151c6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: amruth pattanada <amruth.vamadev@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On 03/12/2010 06:46 AM, amruth pattanada wrote:
> Hi
> All
> I require clarification regarding how bytes are stored in scsi_rw
> Command Descriptor Block for READ_6/WRITE_6 commands. In the
> structures below addr is either defined as 3 bytes or 4 bytes or 8
> bytes.How does it correspond to CHS in ATA. I assume addr[0]=Cylinder,
> addr[1]=head and addr[2]=sectors.Is my assumption correct. How does it
> map if it is 4/8 bytes addr.Is 3 bytes addr corresponds to 24 bit LBA,
> then how do we map 48 bit LBA. All scsi CDB structures are below.Any
> inputs will be highly appreciated.

Use the source, Luke.

All the answers you seek, drivers/ata/libata-scsi.c has, Yoda says.

	Jeff



