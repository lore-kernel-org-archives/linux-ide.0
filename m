From: amruth pattanada <amruth.vamadev@gmail.com>
Subject: CHS to LBA mapping for SCSI 6/10/12/16 byte RW CDB
Date: Fri, 12 Mar 2010 17:16:17 +0530
Message-ID: <9edb119c1003120346r34c1c145t2be07595f9b151c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f196.google.com ([209.85.223.196]:59500 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784Ab0CLLqT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Mar 2010 06:46:19 -0500
Received: by iwn34 with SMTP id 34so965677iwn.15
        for <linux-ide@vger.kernel.org>; Fri, 12 Mar 2010 03:46:17 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>

Hi
All
I require clarification regarding how bytes are stored in scsi_rw
Command Descriptor Block for READ_6/WRITE_6 commands. In the
structures below addr is either defined as 3 bytes or 4 bytes or 8
bytes.How does it correspond to CHS in ATA. I assume addr[0]=Cylinder,
addr[1]=head and addr[2]=sectors.Is my assumption correct. How does it
map if it is 4/8 bytes addr.Is 3 bytes addr corresponds to 24 bit LBA,
then how do we map 48 bit LBA. All scsi CDB structures are below.Any
inputs will be highly appreciated.

//6 byte CDB
struct scsi_rw_6
{
        u_int8_t opcode;
        u_int8_t addr[3];
/* only 5 bits are valid in the MSB address byte */
#define SRW_TOPADDR     0x1F
        u_int8_t length;
        u_int8_t control;
};
//10 bytes CDB
struct scsi_rw_10
{
        u_int8_t opcode;
#define SRW10_RELADDR   0x01
/* EBP defined for WRITE(10) only */
#define SRW10_EBP       0x04
#define SRW10_FUA       0x08
#define SRW10_DPO       0x10
        u_int8_t byte2;
        u_int8_t addr[4];
        u_int8_t reserved;
        u_int8_t length[2];
        u_int8_t control;
};
//12 bytes CDB
struct scsi_rw_12
{
        u_int8_t opcode;
#define SRW12_RELADDR   0x01
#define SRW12_FUA       0x08
#define SRW12_DPO       0x10
        u_int8_t byte2;
        u_int8_t addr[4];
        u_int8_t length[4];
        u_int8_t reserved;
        u_int8_t control;
};

//16 bytes CDB
struct scsi_rw_16
{
        u_int8_t opcode;
#define        SRW16_RELADDR   0x01
#define        SRW16_FUA       0x08
#define        SRW16_DPO       0x10
        u_int8_t byte2;
        u_int8_t addr[8];
        u_int8_t length[4];
        u_int8_t reserved;
        u_int8_t control;
};

Thanks
Amruth p.v
