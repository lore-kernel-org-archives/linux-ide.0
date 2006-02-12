From: Tejun <htejun@gmail.com>
Subject: Re: [PATCH 3/3] ahci: add softreset
Date: Sun, 12 Feb 2006 13:58:11 +0900
Message-ID: <43EEC063.6050704@gmail.com>
References: <11396427632078-git-send-email-htejun@gmail.com> <43EE72D5.1050005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:40945 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932209AbWBLE6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 23:58:19 -0500
Received: by zproxy.gmail.com with SMTP id 16so725681nzp
        for <linux-ide@vger.kernel.org>; Sat, 11 Feb 2006 20:58:18 -0800 (PST)
In-Reply-To: <43EE72D5.1050005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> +static int ahci_wait_for_bit(void __iomem *reg, u32 mask, u32 val,
>> +                 unsigned long interval_msec,
>> +                 unsigned long timeout_msec)
>> +{
>> +    unsigned long timeout;
>> +    u32 tmp;
>> +
>> +    timeout = jiffies + (timeout_msec * HZ) / 1000;
>> +    do {
>> +        tmp = readl(reg);
>> +        if ((tmp & mask) != val)
> 
> 
> IMO the sense of this test should be reversed, as the above line of code 
> is the opposite of what the function name implies.

It didn't use to have @mask and just tested for a single bit to clear. 
Some piece of currently dropped code needed @mask, @val stuff and the 
changed function got left I think.  I'll reverse the testing logic and 
rename the function to something more appropriate - probably 
ahci_poll_register().

> 
>> +            return 0;
>> +        msleep(interval_msec);
>> +    } while (time_before(jiffies, timeout));
>> +
>> +    return -1;
>> +}
>> +
>> +static int ahci_softreset(struct ata_port *ap, int verbose, unsigned 
>> int *class)
>> +{
[--snip--]
>> +    /* issue the second D2H Register FIS */
>> +    ahci_fill_cmd_slot(pp, cmd_fis_len);
>> +
>> +    tf.ctl &= ~ATA_SRST;
>> +    ata_tf_to_fis(&tf, fis, 0);
>> +    fis[1] &= ~(1 << 7);    /* turn off Command FIS bit */
>> +
>> +    writel(1, port_mmio + PORT_CMD_ISSUE);
>> +    readl(port_mmio + PORT_CMD_ISSUE);    /* flush */
>> +
>> +    /* spec mandates ">= 2ms" before checking status.
>> +     * We wait 150ms, because that was the magic delay used for
>> +     * ATAPI devices in Hale Landis's ATADRVR, for the period of time
>> +     * between when the ATA command register is written, and then
>> +     * status is checked.  Because waiting for "a while" before
>> +     * checking status is fine, post SRST, we perform this magic
>> +     * delay here as well.
>> +     */
>> +    msleep(150);
>> +
>> +    *class = ATA_DEV_NONE;
>> +    if (sata_dev_present(ap)) {
>> +        if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
>> +            rc = -EIO;
>> +            reason = "device not ready";
>> +            goto fail;
>> +        }
> 
> 
> On AHCI, are you sure this busy_sleep is even necessary?
> 

We should wait for something before proceeding with classfication.  The 
second FIS turns off SRST and the device will respond with class 
signature when it gets out of reset status, which ends up clearing BUSY. 
  We can either wait for the issue bit to clear as in the the first FIS 
or above.  Do you think waiting for issue bit clearance is better?

Thanks.

-- 
tejun
