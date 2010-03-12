From: Tejun Heo <tj@kernel.org>
Subject: Re: CHS to LBA mapping for SCSI 6/10/12/16 byte RW CDB
Date: Sat, 13 Mar 2010 07:06:06 +0900
Message-ID: <4B9ABACE.6010402@kernel.org>
References: <9edb119c1003120346r34c1c145t2be07595f9b151c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53758 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938Ab0CLWDP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Mar 2010 17:03:15 -0500
In-Reply-To: <9edb119c1003120346r34c1c145t2be07595f9b151c6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: amruth pattanada <amruth.vamadev@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On 03/12/2010 08:46 PM, amruth pattanada wrote:
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

They are all LBAs.  You can find relevant documentation at
www.t10.org.  RW commands are defined in SBC.

-- 
tejun
