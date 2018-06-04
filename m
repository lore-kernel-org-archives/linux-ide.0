From: Nixiaoming <nixiaoming@huawei.com>
Subject: For help, whether to check the return value of sata_scr_read should
 be added in sata_print_link_status
Date: Mon, 4 Jun 2018 03:32:07 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A6828C7@dggemm507-mbx.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: zh-CN
Sender: linux-kernel-owner@vger.kernel.org
To: "tj@kernel.org" <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello
I have trouble reading the code, I hope you can help guide

The function sata_print_link_status in the file drivers/ata/libata-core.c checks the return value when the function sata_scr_read is called on line 3009, 
but does not check the return value when calling sata_scr_read on line 3011.
Why are two calls handled differently?
Is there any other code logic that guarantees that the 3011 line will not return an exception? 

drivers/ata/libata-core.c :
3005 static void sata_print_link_status(struct ata_link *link)
3006 {
3007     u32 sstatus, scontrol, tmp;
3008
3009     if (sata_scr_read(link, SCR_STATUS, &sstatus))
3010         return;
3011     sata_scr_read(link, SCR_CONTROL, &scontrol);
3012
3013     if (ata_phys_link_online(link)) {

Thanks
