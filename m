From: Jeremy Jackson <jerj@coplanar.net>
Subject: 2.4.23 IDE hang on boot with two single-channel controllers
Date: Mon, 26 Jan 2004 09:44:49 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <401527E1.6040108@coplanar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from CPE0020afeeb1ac-CM014250013274.cpe.net.cable.rogers.com ([24.114.21.153]:7440
	"EHLO hoby.coplanar.net") by vger.kernel.org with ESMTP
	id S263771AbUAZOoy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2004 09:44:54 -0500
Received: from coplanar.net (CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com [24.112.162.124])
	(authenticated bits=0)
	by hoby.coplanar.net (8.12.3/8.12.3/Debian-6.6) with ESMTP id i0QEinmD022070
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 26 Jan 2004 09:44:53 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi All,

Already posted this to linux-kernel.

kdb shows proc_ide_create() stuck in a loop when booting on a Compaq 
Armada 7730MT while attached to the docking station.

This is a unique IDE hardware setup.  Channel ide0's controller is in 
the laptop, while ide1 is a separate controller (pci device) in the 
docking station and is not always present.

This seems to be triggering a bug in ide-proc.c:

void proc_ide_create(void)
{
#ifdef CONFIG_BLK_DEV_IDEPCI
         ide_pci_host_proc_t *p = ide_pci_host_proc_list;
#endif /* CONFIG_BLK_DEV_IDEPCI */

         proc_ide_root = proc_mkdir("ide", 0);
         if (!proc_ide_root) return;

         create_proc_ide_interfaces();

         create_proc_read_entry("drivers", 0, proc_ide_root,
                                 proc_ide_read_drivers, NULL);

#ifdef CONFIG_BLK_DEV_IDEPCI
         while (p != NULL)  <------------------- INFINITE LOOP HERE
         {
                 if (p->name != NULL && p->set == 1 && p->get_info != NULL)
                 {
                         p->parent = proc_ide_root;
                         create_proc_info_entry(p->name, 0, p->parent, 
p->get_info);
                         p->set = 2;
                 }
                 p = p->next;
         }
#endif /* CONFIG_BLK_DEV_IDEPCI */
}

I'm not sure if the problem is in the loop or bad data being setup 
before it starts.

Assistance fixing it would be appreciated.

Regards,

Jeremy Jackson

