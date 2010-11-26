From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: kernel problems with smart on LSI-92xx
Date: Fri, 26 Nov 2010 21:42:21 +0600
Message-ID: <4CEFD55D.8060200@ngs.ru>
References: <4CD9A09D.7000508@ngs.ru> <87y690hs3r.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout10.ngs.ru ([195.93.186.216]:31645 "EHLO smtpout.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173Ab0KZPmS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Nov 2010 10:42:18 -0500
In-Reply-To: <87y690hs3r.fsf@nemi.mork.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: linux-ide@vger.kernel.org

   It appears that passing self-test command to SATA disk does not work=
 too.=20
Although nobody reports any error, self-test actually just does not sta=
rt.

smartctl -d megaraid,10 -t long /dev/sg0

smartctl 5.40 2010-10-16 r3189 [x86_64-unknown-linux-gnu] (local build)
Copyright (C) 2002-10 by Bruce Allen, http://smartmontools.sourceforge.=
net

/dev/sg0 [megaraid_disk_10] [SAT]: Device open changed type from 'megar=
aid' to 'sat'
=3D=3D=3D START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION =3D=3D=3D
Sending command: "Execute SMART Extended self-test routine immediately =
in=20
off-line mode".
Drive command "Execute SMART Extended self-test routine immediately in =
off-line=20
mode" successful.
Testing has begun.
Please wait 255 minutes for test to complete.
Test will complete after Sat Nov 27 01:54:44 2010

Use smartctl -X to abort test.


11.11.2010 20:06, Bj=C3=B8rn Mork =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Bokhan Artem<aptem@ngs.ru>  writes:
>
>> Hello.
>>
>> I have kernel problems when trying to run smart commands on LSI-92xx
>> controller.
>>
>> Running self-test  on SAS disk (smartctl /dev/sda -dmegaraid,24 -t
>> long) with smartmontools causes kernel oops (?) (and segfault). Look
>> in attachment for dmesg.
>>
>> strace of smartctl:
>>
>> mknod("/dev/megaraid_sas_ioctl_node", S_IFCHR, makedev(251, 0)) =3D =
-1 EEXIST
>> (File exists)
>> close(4)                                =3D 0
>> munmap(0x7f4be3a9f000, 4096)            =3D 0
>> open("/dev/megaraid_sas_ioctl_node", O_RDWR) =3D 4
>> ioctl(4, MTRRIOC_SET_ENTRY, 0x7fffa574ed30) =3D 0
>> ioctl(4, MTRRIOC_SET_ENTRY, 0x7fffa574eb30) =3D 0
>> ioctl(4, MTRRIOC_SET_ENTRY<unfinished ...>
>> +++ killed by SIGSEGV +++
>>
>>
>> Viewing  smart info is OK (smartctl /dev/sda -dmegaraid,24 -a).
>> Running self-test on SATA disk on the same system is OK.
>>
>> The problem is reproducible with 2.6.32 and 2.6.36 kernels.
> A quick look at this reveals that smartctl will happily do a
> MEGASAS_IOC_FIRMWARE ioctl with sge_count =3D 1 and sgl[0].iov_len =3D=
 0 if
> it is sending a command with dataLen =3D=3D 0 :
>
>
> /* Issue passthrough scsi command to PERC5/6 controllers */
> bool linux_megaraid_device::megasas_cmd(int cdbLen, void *cdb,
>    int dataLen, void *data,
>    int /*senseLen*/, void * /*sense*/, int /*report*/)
> {
>    struct megasas_pthru_frame    *pthru;
>    struct megasas_iocpacket      uio;
>    struct megasas_iocpacket      uio;
>    int rc;
>
>    memset(&uio, 0, sizeof(uio));
>    pthru =3D (struct megasas_pthru_frame *)uio.frame.raw;
>    pthru->cmd =3D MFI_CMD_PD_SCSI_IO;
>    int rc;
>
>    memset(&uio, 0, sizeof(uio));
>    pthru =3D (struct megasas_pthru_frame *)uio.frame.raw;
>    pthru->cmd =3D MFI_CMD_PD_SCSI_IO;
>    pthru->cmd_status =3D 0xFF;
>    pthru->scsi_status =3D 0x0;
>    pthru->target_id =3D m_disknum;
>    pthru->lun =3D 0;
>    pthru->cdb_len =3D cdbLen;
>    pthru->timeout =3D 0;
>    pthru->flags =3D MFI_FRAME_DIR_READ;
>    pthru->sge_count =3D 1;
>    pthru->data_xfer_len =3D dataLen;
>    pthru->sgl.sge32[0].phys_addr =3D (intptr_t)data;
>    pthru->sgl.sge32[0].length =3D (uint32_t)dataLen;
>    memcpy(pthru->cdb, cdb, cdbLen);
>
>    uio.host_no =3D m_hba;
>    uio.sge_count =3D 1;
>    uio.sgl_off =3D offsetof(struct megasas_pthru_frame, sgl);
>    uio.sgl[0].iov_base =3D data;
>    uio.sgl[0].iov_len =3D dataLen;
>
>    rc =3D 0;
>    errno =3D 0;
>    rc =3D ioctl(m_fd, MEGASAS_IOC_FIRMWARE,&uio);
>    if (pthru->cmd_status || rc !=3D 0) {
>      if (pthru->cmd_status =3D=3D 12) {
>        return set_err(EIO, "megasas_cmd: Device %d does not exist\n",=
 m_disknum);
>      }
>      return set_err((errno ? errno : EIO), "megasas_cmd result: %d.%d=
 =3D %d/%d",
>                     m_hba, m_disknum, errno,
>                     pthru->cmd_status);
>    }
>    return true;
> }
>
>
>
> The kernel bug is that the zero valued sgl[0].iov_len is passed
> unmodified to megasas_mgmt_fw_ioctl() which again passes it on as siz=
e
> to dma_alloc_coherent():
>
>          /*
>           * For each user buffer, create a mirror buffer and copy in
>           */
>          for (i =3D 0; i<  ioc->sge_count; i++) {
>                  kbuff_arr[i] =3D dma_alloc_coherent(&instance->pdev-=
>dev,
>                                                      ioc->sgl[i].iov_=
len,
>                                                      &buf_handle, GFP=
_KERNEL);
>
>
>
> And it looks like most (all?) of the dma_alloc_coherent()
> implementations will use get_order(size) to compute the necessary
> allocation. This will fail if size =3D=3D 0.
>
> On the other hand, I may have misunderstood this entirely....
>
> But if you dare, you could try the attached patch (compile tested onl=
y
> as I don't have the hardware) and see if it helps.  Let me know how i=
t
> goes, and I'll forward it to the megaraid manitainers if it really fi=
xes
> your problem.
>
>
>
>
> Bj=C3=B8rn
>

